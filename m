From: Jurij Smakov <jurij@wooyd.org>
Date: Mon, 30 Jan 2006 08:34:51 +0000
Subject: Attempts to set date with 'date -s' hang the machine
Message-Id: <Pine.LNX.4.63.0601300019430.4017@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

It has been recently reported on debian-sparc mailing list [0] that=20
attempting to set date using 'date -s' results in a hang. I was able to=20
reproduce it with 2.6.15.1 (on Ultra60, original report was for Ultra5)=20
and did some preliminary debugging. It appears that the hang happens in=20
get_compat_timespec(), called from compat_sys_clock_settime() in=20
kernel/compat.c. I have printed the values of pointers passed to=20
get_compat_timespec(), for the call which hangs the box they looked like=20
this:

get_compat_timespec: ts=FFfff800bf7a7e80
get_compat_timespec: ts->tv_sec=FFfff800bf7a7e80
get_compat_timespec: ts->tv_nsec=FFfff800bf7a7e88
get_compat_timespec: cts=FFffffffef8d7cd8
get_compat_timespec: cts->tv_sec=FFffffffef8d7cd8
get_compat_timespec: cts->tv_nsec=FFffffffef8d7cdc

I've also got the debugging output from a few other (successful)
calls to get_compat_timespec(), the output then typically looks=20
like that:

get_compat_timespec: ts=FFfff800bfbc7e80
get_compat_timespec: ts->tv_sec=FFfff800bfbc7e80
get_compat_timespec: ts->tv_nsec=FFfff800bfbc7e88
get_compat_timespec: cts=00000000efa23c88
get_compat_timespec: cts->tv_sec=00000000efa23c88
get_compat_timespec: cts->tv_nsec=00000000efa23c8c

Here the higher byte of the cts is set to zero, as I believe it should be=20
for a userspace address. In the failing case the upper byte is set to
ffffffff, which probably causes the problem. I'd appreciate any ideas on=20
how to resolve this issue.

[0] http://lists.debian.org/debian-sparc/2006/01/msg00129.html

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
