From: Kumba <kumba@gentoo.org>
Date: Tue, 26 Jul 2005 23:34:39 +0000
Subject: Re: Setting the clock hangs Sun Blade 100
Message-Id: <42E6C88F.6080703@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <42E608E7.5090905@cpttm.org.mo>
In-Reply-To: <42E608E7.5090905@cpttm.org.mo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Kent Tong wrote:
> Hi,
> 
> I'm running Debian Sarge on a Sun Blade 100. Everything
> works fine except that I can't set the system clock
> using the "date" command. Whenever I do that, the system
> hangs completely and I have to turn off the power to
> get it back to life.
> 
> All I want is to correct the time (it's about 30 minutes
> too early). Is there any other way to do that?
> 
> Could this be related to
> http://040.digital-bless.com/texts/Unofficial_Sun_Blade_100_FAQ.htm#file_76
> ?

Tried an NTP client to see if that also hangs the system?  And what's the 
specific kernel revision?


--Kumba


-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
