From: Bernd Zeimetz <bernd@bzed.de>
Date: Fri, 26 Oct 2007 12:23:29 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <4721DC41.50302@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

just got linked to this thread, so here's a bit input form me :)


>> 1) system type
> 
> A Sun Fire 280R, with two CPU boards, each carrying a TI UltraSparc III
> (Cheetah), and 2 GB of RAM. If you need more info, just say.
> 
> (Bernd Zeimetz has previously suggested that the problem is linked to
> the processor type, the USIII.)

It seems to hit USIII machines with 2 CPUs in one tray much more hard
than US II, but once a month our Ultra60 (running two US II) has the
same issues - it got much better with since
179c85ea53bef807621f335767e41e23f86f01df, though. before the mentioned
patch it died a few times per day. Seems it got better on the USIII
here, too (we have a v880 here, the large version of Josip's machine,
with 2x 2 CPUs), but it still dies way too often, just not useable in
the current state.


> 
>> 2) compiler used to build kernel and is it SMP?
> 
> gcc (GCC) 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)

same compiler here.
Please note that non-SMP kernels do not boot on those US-III machines at
all (at least I didn't find a single one which does).



Cheers,

Bernd
