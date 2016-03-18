#!/bin/bash
# proxy.plugin.sh
# sej 2016 03 15


disable-proxy ()
{
#	about 'Disables proxy settings for Bash, npm and SSH'
#	group 'proxy'

	unset http_proxy
	unset https_proxy
	unset ftp_proxy
	unset HTTP_PROXY
	unset HTTPS_PROXY
	unset ALL_PROXY
	unset no_proxy
	unset NO_PROXY
	echo "Disabled proxy environment variables"

	ssh-disable-proxy
	git-global-disable-proxy
}

enable-proxy ()
{
#	about 'Enables proxy settings for Bash, npm and SSH'
#	group 'proxy'

	export http_proxy=$BASH_IT_HTTP_PROXY
	export https_proxy=$BASH_IT_HTTPS_PROXY
	export ftp_proxy=$BASH_IT_HTTP_PROXY
	export HTTP_PROXY=$http_proxy
	export HTTPS_PROXY=$https_proxy
	export ALL_PROXY=$http_proxy
	export no_proxy=$BASH_IT_NO_PROXY
	export NO_PROXY=$no_proxy
	echo "Enabled proxy environment variables"

	ssh-enable-proxy
	git-global-enable-proxy	
}

enable-proxy-alt ()
{
#	about 'Enables alternate proxy settings for Bash, npm and SSH'
#	group 'proxy'

	export http_proxy=$BASH_IT_HTTP_PROXY_ALT
	export https_proxy=$BASH_IT_HTTPS_PROXY_ALT
	export HTTP_PROXY=$http_proxy
	export HTTPS_PROXY=$https_proxy
	export ALL_PROXY=$http_proxy
	export no_proxy=$BASH_IT_NO_PROXY
	export NO_PROXY=$no_proxy
	echo "Enabled alternate proxy environment variables"

	ssh-enable-proxy
	git-enable-proxy
}

show-proxy ()
{
#	about 'Shows the proxy settings for Bash, Git, npm and SSH'
#	group 'proxy'

	echo ""
	echo "Environment Variables"
	echo "====================="
	env | grep -i "proxy" | grep -v "BASH_IT"

	bash-it-show-proxy
	git-global-show-proxy
	ssh-show-proxy
}

proxy-help ()
{
#	about 'Provides an overview of the bash-it proxy configuration'
#	group 'proxy'

	cat << EOF
Bash-it provides support for enabling/disabling proxy settings for various shell tools.

The following backends are currently supported (in addition to the shell's environment variables): Git, SVN, npm, ssh

Bash-it uses the following variables to set the shell's proxy settings when you call 'enable-proxy'.
These variables are best defined in a custom script in bash-it's custom script folder ('$BASH_IT/custom'),
e.g. '$BASH_IT/custom/proxy.env.bash'
* BASH_IT_HTTP_PROXY and BASH_IT_HTTPS_PROXY: Define the proxy URL to be used, e.g. 'http://localhost:1234'
* BASH_IT_NO_PROXY: A comma-separated list of proxy exclusions, e.g. '127.0.0.1,localhost'

Run 'glossary proxy' to show the available proxy functions with a short description.
EOF

	bash-it-show-proxy
}

bash-it-show-proxy ()
{
#	about 'Shows the bash-it proxy settings'
#	group 'proxy'

	echo ""
	echo "bash-it Environment Variables"
	echo "============================="
	echo "(These variables will be used to set the proxy when you call 'enable-proxy')"
	echo ""
	env | grep -e "BASH_IT.*PROXY"
}


git-global-show-proxy ()
{
#	about 'Shows global Git proxy settings'
#	group 'proxy'

	if $(command -v git &> /dev/null) ; then
		echo ""
		echo "Git (Global Settings)"
		echo "====================="
		echo "Git (Global) HTTP  proxy: " `git config --global --get http.proxy`
		echo "Git (Global) HTTPS proxy: " `git config --global --get https.proxy`
	fi
}

git-global-disable-proxy ()
{
#	about 'Disables global Git proxy settings'
#	group 'proxy'

    if $(command -v git &> /dev/null) ; then
	#git config --global --unset-all http.proxy
	#git config --global --unset-all https.proxy
	echo "[http]" > $GIT_MYAUTH
	echo "[https]" >> $GIT_MYAUTH
	echo "Disabled global Git proxy settings"
    fi
}

git-global-enable-proxy ()
{
#	about 'Enables global Git proxy settings'
#	group 'proxy'

    if $(command -v git &> /dev/null) ; then
	git-global-disable-proxy
	echo "[http]" > $GIT_MYAUTH
	echo "proxy = $http_proxy" >> $GIT_MYAUTH
	echo "[https]" >> $GIT_MYAUTH
	echo "proxy = $https_proxy" >> $GIT_MYAUTH
	#git config --global --add http.proxy $BASH_IT_HTTP_PROXY
	#git config --global --add https.proxy $BASH_IT_HTTPS_PROXY
	echo "Enabled global Git proxy settings"
	fi
}

git-show-proxy ()
{
#	about 'Shows current Git project proxy settings'
#	group 'proxy'

	if $(command -v git &> /dev/null) ; then
		echo "Git Project Proxy Settings"
		echo "====================="
		echo "Git HTTP  proxy: " `git config --get http.proxy`
		echo "Git HTTPS proxy: " `git config --get https.proxy`
	fi
}

git-disable-proxy ()
{
#	about 'Disables current Git project proxy settings'
#	group 'proxy'

	if $(command -v git &> /dev/null) ; then
		git config --unset-all http.proxy
		git config --unset-all https.proxy
		echo "Disabled Git project proxy settings"
	fi
}

git-enable-proxy ()
{
#	about 'Enables current Git project proxy settings'
#	group 'proxy'

	if $(command -v git &> /dev/null) ; then
		git-disable-proxy

		git config --add http.proxy $BASH_IT_HTTP_PROXY
		git config --add https.proxy $BASH_IT_HTTPS_PROXY
		echo "Enabled Git project proxy settings"
	fi
}



ssh-show-proxy ()
{
#	about 'Shows SSH config proxy settings (from ~/.ssh/config)'
#	group 'proxy'

	if [ -f ~/.ssh/config ] ; then
		echo ""
		echo "SSH Config Enabled in ~/.ssh/config"
		echo "==================================="
		awk '
		    $1 == "Host" {
		        host = $2;
		        next;
		    }
		    $1 == "ProxyCommand" {
		        $1 = "";
		        printf "%s\t%s\n", host, $0
		    }
		' ~/.ssh/config | column -t

		echo ""
		echo "SSH Config Disabled in ~/.ssh/config"
		echo "===================================="
		awk '
		    $1 == "Host" {
		        host = $2;
		        next;
		    }
		    $0 ~ "^#.*ProxyCommand.*" {
		        $1 = "";
		        $2 = "";
		        printf "%s\t%s\n", host, $0
		    }
		' ~/.ssh/config | column -t
	fi
}

ssh-disable-proxy ()
{
#	about 'Disables SSH config proxy settings'
#	group 'proxy'

	if [ -f ~/.ssh/config ] ; then
		sed -e's/^.*ProxyCommand/#	ProxyCommand/' -i --follow-symlinks  ~/.ssh/config
		echo "Disabled SSH config proxy settings"
	fi
}


ssh-enable-proxy ()
{
#	about 'Enables SSH config proxy settings'
#	group 'proxy'

	if [ -f ~/.ssh/config ] ; then
		sed -e's/#	ProxyCommand/	ProxyCommand/' -i --follow-symlinks  ~/.ssh/config
		echo "Enabled SSH config proxy settings"
	fi
}
