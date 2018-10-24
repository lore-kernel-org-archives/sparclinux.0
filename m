From: David Miller <davem@davemloft.net>
Date: Wed, 24 Oct 2018 15:40:00 +0000
Subject: Re: [sparc vdso] compile failure in v4.19-4243-ga978a5b - operation combines symbols in different se
Message-Id: <20181024.084000.1244181213524150633.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <748cfe51-e74d-f6fc-a806-7689a86399e0@linux.ee>
In-Reply-To: <748cfe51-e74d-f6fc-a806-7689a86399e0@linux.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 24 Oct 2018 12:26:50 +0300

> This happens on all 4 with 2015-08 32-bit userspace that I tested
> todays git on:
> 
>   CC      arch/sparc/vdso/vclock_gettime.o
> {standard input}: Assembler messages:
> {standard input}:99: Error: operation combines symbols in different
> segments

What version of binutils?  "as --version" should be enough.
