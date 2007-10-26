From: Bernd Zeimetz <bernd@bzed.de>
Date: Fri, 26 Oct 2007 12:30:21 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <4721DDDD.70509@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


> It seems that instead of getting stuck in the kernel where I
> thought it would, the process gets stuck elsewhere and
> also tends to loop allocating memory until all memory in the
> machine is exhausted and the OOM killer starts to try and
> kill processes left and right.

at least it runs with 100% CPU, attaching strace to the pid doesn't give
any results....
strace-ing the whole process doesn't result in more useful output, but
the hanging processes were killable when they were running under strace...


Cheers,

Bernd
