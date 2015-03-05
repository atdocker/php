#!/bin/bash

### BEGIN INIT INFO
# Provides:          php55-fpm
# Required-Start:    $remote_fs $network
# Required-Stop:     $remote_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts php55-fpm
# Description:       starts the PHP FastCGI Process Manager daemon
### END INIT INFO

prefix=/opt/php55
exec_prefix=${prefix}
php_fpm_BIN=/opt/php55/sbin/php-fpm
php_fpm_CONF=/opt/php55/etc/php55-fpm.conf
php_fpm_PID=/var/run/php55-fpm.pid
php_opts="--fpm-config $php_fpm_CONF --pid $php_fpm_PID -c /opt/php55/etc/php55.ini"

wait_for_pid () {
	try=0

	while test $try -lt 5 ; do

		case "$1" in
			'created')
			if [ -f "$2" ] ; then
				try=''
				break
			fi
			;;

			'removed')
			if [ ! -f "$2" ] ; then
				try=''
				break
			fi
			;;
		esac

		echo -n .
		try=`expr $try + 1`
		sleep 1

	done

}

case "$1" in
	start)
		echo -n "Starting php55-fpm.."

		$php_fpm_BIN --daemonize $php_opts

		if [ "$?" != 0 ] ; then
			echo " failed"
			exit 1
		fi

		wait_for_pid created $php_fpm_PID

		if [ -n "$try" ] ; then
			echo " failed"
			exit 1
		else
			echo " done"
		fi
	;;

	stop)
		echo -n "Gracefully shutting down php55-fpm.."

		if [ ! -r $php_fpm_PID ] ; then
			echo "warning, no pid file found - php55-fpm is not running ?"
			exit 1
		fi

		kill -QUIT `cat $php_fpm_PID`

		wait_for_pid removed $php_fpm_PID

		if [ -n "$try" ] ; then
			echo " failed. Use force-quit"
			exit 1
		else
			echo " done"
		fi
	;;

	status)
		if [ ! -r $php_fpm_PID ] ; then
			echo "php55-fpm is stopped"
			exit 0
		fi

		PID=`cat $php_fpm_PID`
		if ps -p $PID | grep -q $PID; then
			echo "php55-fpm (pid $PID) is running..."
		else
			echo "php55-fpm dead but pid file exists"
		fi
	;;

	force-quit)
		echo -n "Terminating php55-fpm.."

		if [ ! -r $php_fpm_PID ] ; then
			echo "warning, no pid file found - php55-fpm is not running ?"
			exit 1
		fi

		kill -TERM `cat $php_fpm_PID`

		wait_for_pid removed $php_fpm_PID

		if [ -n "$try" ] ; then
			echo " failed"
			exit 1
		else
			echo " done"
		fi
	;;

	restart)
		$0 stop
		$0 start
	;;

	reload)

		echo -n "Reloading service php55-fpm.."

		if [ ! -r $php_fpm_PID ] ; then
			echo "warning, no pid file found - php55-fpm is not running ?"
			exit 1
		fi

		kill -USR2 `cat $php_fpm_PID`

		echo " done"
	;;

	*)
		echo "Usage: $0 {start|stop|force-quit|restart|reload|status}"
		exit 1
	;;

esac
