From: Dennis Gilmore <dennis@ausil.us>
Date: Mon, 03 Jul 2006 00:02:46 +0000
Subject: Re: Oops in tcp_sendmsg on T1000
Message-Id: <200607021902.46352.dennis@ausil.us>
List-Id: <sparclinux.vger.kernel.org>
References: <200607011421.56811.rene@exactcode.de>
In-Reply-To: <200607011421.56811.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Saturday 01 July 2006 7:21 am, Rene Rebe wrote:
> Hi all,
>
> I just test the freshly installed T1000 under load and got a single stray
> oops after 5 hours of uptime with excessive load (software compilation).
> The software is the T2 release from this week (software compiled from
> vanilla sources) with GCC 4.1.1, Kernel 2.6.17.2:
>
> Linux version 2.6.17.2-dist (root@localhost) (gcc version 4.1.1) #1 SMP Fri
> Jun 30 14:30:38 /TOOLCHAIN/localtime 2006
>
> The same kernel binary runs on Ultra30 and Ultra5 since days without any
> problem, however I already can imagine that David will slap me for using
> GCC 4.1.1. Maybe someone is interested anyway:

I am using a 2.6.17pre  kernel  on my T1000 
Linux version 2.6.16-1.2241sp7 (root@arthur.devel.redhat.com) (gcc version 
3.4.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 SMP Thu Jun 29 10:59:22 EDT 2006

i have been using it with an average load of around 10 for a couple of days 
now.  It has received 125gb in that time.  and have not seen any issues at 
all.



-- 
Dennis Gilmore, RHCE
Proud Australian
