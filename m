From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Mon, 06 Dec 2004 00:58:11 +0000
Subject: 2.6.8-1-sparc64 nanosleep does not restart if interrupted by signal
Message-Id: <1102294691.15654.137.camel@duncow>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-72RpO3GF/yC7eplDhH0O"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-72RpO3GF/yC7eplDhH0O
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

All,

I've noticed a problem on 2.6.8.1 sparc64 kernel with the nanosleep
system call (and probably others) where if the system call is
interrupted by a signal (TSTP/CONT in my test case) it doesn't get
restarted and just ends up returning error code -516. I first noticed
this using tail -f <file> terminates if you ctrl-z and then fg it.

pingu:~/src# tail -f /var/log/syslog
...
[1]+  Stopped                 tail -f /var/log/syslog
pingu:~/src# fg
tail -f /var/log/syslog
tail: cannot read realtime clock
pingu:~/src#

Digging into this it turns out that nanosleep is terminating with code
-516 (ERESTART_RESTARTBLOCK). It looks like the kernel is not restarting
the system call using system call using __NR_restart_syscall.

I haven't managed to work out what is wrong but I suspect that something
is wrong with the way that rtrap, do_notify_resume, do_signal,
syscall_restart and handle_signal are playing together. I've run out of
time tonight and wondered if anyone had any insight that might save me a
bit of debugging tomorrow.

I've attached a simple test program that does a 100 second nanosleep. If
you compile this (as 32 or 64 bit binary), run it, then ctrl-z and fg
you will see that it reports a return code of -516.

pingu:~/src# ./nanotest

[1]+  Stopped                 ./nanotest
pingu:~/src# fg
./nanotest
nanosleep returned -516, remainder 98 s, 970954128 ns
pingu:~/src#

Other notes:

a) This all works on 2.4.x (not suprising the code was changed for 2.6)
b) I haven't tested more recent that 2.6.8-1 but the
asm/sparc64/kernel/signal.c (and rtrap.c) code looks unchanged since
then.

Richard

-- 
richm@oldelvet.org.uk

--=-72RpO3GF/yC7eplDhH0O
Content-Disposition: attachment; filename=nanotest.c
Content-Type: text/x-csrc; name=nanotest.c; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

#include <sys/types.h>
#include <time.h>

int main()
{
	struct timespec req;
	struct timespec rem;
	int retval;
	
	req.tv_sec = 100;
	req.tv_nsec = 0;

	retval = nanosleep(&req, &rem);
	printf("nanosleep returned %d, remainder %d s, %d ns\n",
		retval, rem.tv_sec, rem.tv_nsec);

	return 0;
}

--=-72RpO3GF/yC7eplDhH0O--

