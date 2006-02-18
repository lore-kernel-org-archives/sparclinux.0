From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 18 Feb 2006 05:48:11 +0000
Subject: RE: [gentoo-sparc] kernel-2.6.15-r4 (in)stability on U2-SMP, etc.
Message-Id: <Pine.LNX.4.63.0602172131420.3243@bobcat>
List-Id: <sparclinux.vger.kernel.org>
References: <1140008955.4844.42.camel@polylepis.inforead.com>
In-Reply-To: <1140008955.4844.42.camel@polylepis.inforead.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, 17 Feb 2006, Leif Sawyer wrote:

> I can also add that my U2 (2x300) is also having the same lockup
> on high disk activity.  I've been able to 'nice' my portage related
> activity down and avoid it crashing on the last few package emerges,
> but it's not a cure-all.

If you can easily reproduce this problem, could you try to get some useful 
debugging info? If you can drop into prom after machine hangs, what 
backtrace does the ctrace command give you? Could you try compiling the 
kernel with spinlock debugging ang magic sysrq key support and see if you 
can get some information on where it hangs that way?

We are hitting some kind of SMP lockup issues in Debian, however it is 
much harder to reproduce. The automatic sparc build machines (running 
2.6.8) occasionally hang when trying to build large packages, like 
openoffice.org. All attempts to reproduce this failure locally failed so 
far. As it might be caused by the same bug you are hitting, we would be 
*very* interested in any progress on this, since these hangs currently 
are the main obstacle which might prevent the inclusion of sparc port into 
the next official Debian release.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
