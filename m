From: Alex McWhirter <alexmcwhirter@triadic.us>
Date: Thu, 03 Mar 2016 06:29:44 +0000
Subject: Re: Kernels 4.+ are breaking rsync?
Message-Id: <56D7D9D8.7040902@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
References: <56C11585.3060503@triadic.us>
In-Reply-To: <56C11585.3060503@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 02/28/2016 12:57 PM, Al Viro wrote:
> On Sun, Feb 28, 2016 at 06:41:37PM +0100, Sam Ravnborg wrote:
>> On Sun, Feb 21, 2016 at 09:14:45PM +0100, Sam Ravnborg wrote:
>>> Added Al Viro, as author of the commit git bisect pointed out.
>> Al, have you by chance looked at this bug report?
> Not enough details...
>
>> Alex, did you try to revert just this single patch on mainline
>> to verify this _is_ indeed the culprint?
> Not a chance - a lot of stuff past it depends on that series.
>
> How does rsync die there?  oops, segfault, something else?  Any way to
> reproduce it?

Sorry guys, been busy with work and haven't had time to look at it since
the last email. Ill try to get to it on Friday.


As far as the breakage goes, rsync just exits with an error. See the
below strace (full strace is in the initial email.)

select(6, [5], [], [5], {60, 0})        = 1 (in [5], left {59, 998888})
read(5, "5\0\0\nABORTING due to invalid path"..., 32768) = 150
write(2, "ABORTING due to invalid path fro"..., 52ABORTING due to invalid path from sender: /app-admin) = 52
write(2, "\n", 1
)                       = 1
write(2, "rsync error: protocol incompatib"..., 80rsync error: protocol incompatibility (code 2) at flist.c(2507) [receiver=3.1.2]) = 80
write(2, "\n", 1
)                       = 1
rt_sigaction(SIGUSR1, {SIG_IGN, [], 0}, NULL, 0xfff0000100373b98, 8) = 0
rt_sigaction(SIGUSR2, {SIG_IGN, [], 0}, NULL, 0xfff0000100373b98, 8) = 0
waitpid(11615, 0x7feffa7a51c, WNOHANG)  = 0
getpid()                                = 11614
kill(11615, SIGUSR1)                    = 0
select(6, [5], [4], [5], {30, 0})       = 1 (out [4], left {29, 999992})
write(4, "\0\0\0]", 4)                  = 4
gettimeofday({1455346230, 116389}, NULL) = 0
select(6, [5], [], [5], {30, 0})        = 1 (in [5], left {29, 899516})
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid615, si_uid=0, si_status=2, si_utime=0, si_stime=0} ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) = 2}], WNOHANG) = 11615
waitpid(-1, 0x7feffa781ac, WNOHANG)     = -1 ECHILD (No child processes)
rt_sigreturn()                          = 1
read(5, "", 32768)                      = 0
rt_sigaction(SIGUSR1, {SIG_IGN, [], 0}, NULL, 0xfff0000100373b98, 8) = 0
rt_sigaction(SIGUSR2, {SIG_IGN, [], 0}, NULL, 0xfff0000100373b98, 8) = 0
exit_group(2)                           = ?
+++ exited with 2 +++



When comparing to a working kernel, at the first line of my snippet,{59,
998888} is different. Now like i said this goes beyond my knowledge
scope, but i assume this identifies a file descriptor. Anyways, ill get
some more comparisons on Friday.

