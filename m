From: David Miller <davem@davemloft.net>
Date: Fri, 26 Oct 2007 11:30:38 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071026.043038.68704959.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 25 Oct 2007 17:07:36 +0200

> I did this in a chrooted bash:
> 
> for i in $(seq 0 100); do (dpkg-query -s python2.5-minimal > /dev/null &); done
> 
> And now the machine went catatonic. :(
> 
> Thankfully the console is still vaguely operational - I can enter my
> username to log in, but I can't get the Password prompt to appear.
> Magic SysRq still works - if you need any output from it, tell me.

Thanks for testing.

It seems that instead of getting stuck in the kernel where I
thought it would, the process gets stuck elsewhere and
also tends to loop allocating memory until all memory in the
machine is exhausted and the OOM killer starts to try and
kill processes left and right.

I'll think about this some more.
