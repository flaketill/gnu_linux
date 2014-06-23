arch=$(uname -m)
    	echo $arch

    	#Checking your Ubuntu Version
    	lsb_release -a | grep "Release" | awk '{ print $2}' | grep '[0-9]'
    	lscpu | grep "Architecture\|Arquitectura"
    	# install_with_package_manager lsb-core  
    	# install_with_package_manager cpuid
    	# install_with_package_manager ia32-libs

    	$(lsb_release -sc)

    	[ "$arch" = "x86_64" ] && echo "x86_64" || echo "i686"

  #   	if cpuid -l; then
		#     echo "amd64"
		# else
		#     echo "i386"
		# fi
		
		#grep flags /proc/cpuinfo
		dpkg --print-architecture

		# Provide usage information if not arguments were supplied
		if [ "$#" -le 0 ]; then
		        echo "Usage: $0 <executable> [<argument>...]" >&2

		        #exit 1
		else 
			echo "mmm"
		fi

		# Check if the directory exists
		if [ -d "$D" ]; then
		        # If it does, cd into it
		        cd "$D"
		        echo "cd on directory"
		else
				echo "no exit di"

		        if [ "$D" ]; then
		                # Complain if a directory was specified, but does not exist
		                echo "Directory '$D' does not exist" >&2

		                #exit 1
		        fi
		fi


		platform='unknown'
		unamestr==$(uname -m)
		if [[ "$unamestr" == 'Linux' ]]; then
		   platform='linux'
		elif [[ "$unamestr" == 'FreeBSD' ]]; then
		   platform='freebsd'
		fi

		echo $platform

		HS_NO=0

		if [ $HS_NO -ge 1 ];then 
		echo "ok"
        else
                echo "No changes -- hosts"
        fi

        if [ -e $PATH_AR/10-vboxdrv.rules ]; then #if file exist
        	echo "exit rule 10-vboxdrv"
        else
        	echo "no exit rule"
        fi

        # bash wps_es.sh 

		#Search axel, wget o curl in your OS
           echo "Por favor espere, buscando dependencias para scripts ..."
            count_pkg=$(whereis axels | grep -c "bin/axel")

            #echo "instaldo o no: $count_pkg"

            if [ $count_pkg -eq 1 ]; then
                
                echo "Ok, dependencias instaladas .."
                
            else
                echo "Ocurrio un error al tratar de instalar dependencias, por favor comuniquese con el Ing. Armando Ibarra .."
            fi

            #http://stackoverflow.com/questions/687948/timeout-a-command-in-bash-without-unnecessary-delay
            echo "Proceso terminado, se reiniciara su OS en 3 segundos..."


