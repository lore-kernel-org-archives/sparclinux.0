From: gavin duley <gduley@une.edu.au>
Date: Mon, 30 Jul 2007 09:45:12 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070730094512.GA19995@snoopy.apana.org.au>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jul 30, 2007 at 02:22:35AM -0700, David Miller <davem@davemloft.net> wrote:
> From: gavin duley <gduley@une.edu.au>
> Date: Mon, 30 Jul 2007 09:16:53 +0000
> 
> > My Sun box is a Sun Ultra 5 with just one processor: a TI UltraSparc
> > IIi (Sabre). From memory, it is 333MHz with 2MB cache.
> 
> What exactly is your test case that fails?

The application that hangs on my machine is iceweasel. The machine is 
running Debian testing:

%:gpd@aragorn:~> uname -a                      [(pts/3) 9:26 on 07-07-30]
Linux aragorn 2.6.18-4-sparc64 #1 Mon Mar 26 11:16:07 UTC 2007 sparc64 GNU/Linux
%:gpd@aragorn:~>                               [(pts/3) 9:40 on 07-07-30]

If I run icewease with strace, it gives the following output when it hangs 
(this also shows that I used kill to kill iceweasel after it hung):

gettimeofday({1185286472, 656275}, NULL) = 0
futex(0xc71d84, FUTEX_WAKE, 1)          = 1
futex(0xc71d80, FUTEX_WAKE, 1)          = 1
read(5, 0xff04d257, 1)                  = -1 EAGAIN (Resource temporarily 
unavailable)
ioctl(3, 0x4004667f, 0xff04d344)        = 0
poll([{fd=3, events=POLLIN}, {fd, events=POLLIN}, {fd, 
events=POLLIN|POLLPRI}, {fd, events=POLLIN|POLLPRI}, {fd, 
events=POLLIN|POLLPRI}, {fd, events=POLLIN|POLLPRI}, {fd=5, 
events=POLLIN, revents=POLLIN}], 7, -1) = 1
gettimeofday({1185286474, 657891}, NULL) = 0
futex(0xccfc54, FUTEX_WAIT, 1, NULL)    = -1 EINTR (Interrupted system 
call)
--- SIGHUP (Hangup) @ 0 (0) ---
unlink("/home/gpd/.mozilla/firefox/7em5vrni.default/lock") = 0
rt_sigaction(SIGHUP, {SIG_DFL}, NULL, 0xf7dcccf8, 0) = 0
rt_sigprocmask(SIG_UNBLOCK, [HUP], NULL, 8) = 0
tgkill(10471, 10471, SIGHUP)            = 0
--- SIGHUP (Hangup) @ 0 (0) ---
+++ killed by SIGHUP +++

gavin,

[Please cc: me as I'm not on this list. Thanks.]
-- 
Wonder is the beginning of all science.
	-- Aristotle

Gavin Duley
<gduley@une.edu.au>   <gduley@turing.une.edu.au>
http://www-personal.une.edu.au/~gduley/
