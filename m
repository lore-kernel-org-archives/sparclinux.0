From: Dan Kegel <dank@kegel.com>
Date: Mon, 26 Apr 2004 05:12:37 +0000
Subject: Re: cross-toolchain build script; problem with gas for sparc64
Message-Id: <408C9A45.8020005@kegel.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040426032713.GI3647@phunnypharm.org>
In-Reply-To: <20040426032713.GI3647@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Ben Collins wrote:
>>  wget http://kegel.com/crosstool/crosstool-0.28-rc7.tar.gz
>>  tar -xzvf crosstool-0.28-rc7.tar.gz
>>  cd crosstool-0.28-rc7
>>  sh demo-sparc64.sh
>>
>>Sadly, this fails at the moment with
>>  qp_qtoi.s:261: Error: Illegal operands: There are only 32 single 
>>  precision f registers; [0-31]
>>while building glibc.
>>(See also http://sources.redhat.com/ml/binutils/2004-04/msg00686.html)
>>Anyone seen that kind of error before?  It's odd, since the assembler is
>>being passed the -Av9a -64 options, which really ought to tell it
>>there are 64 fp registers, I thought.
> 
> Well, I know for a fact that glibc-2.3.2 builds on sparc64-linux with
> native toolchain, so it must be something in. It's using binutils
> 2.14.90.0.7.

I just tried 2.14.90.0.7, and the test case passes, so
I guess it's a regression in gas.  I'll narrow it down
and post to binutils.
Thanks!
- Dan


-- 
My technical stuff: http://kegel.com
My politics: see http://www.misleader.org for examples of why I'm for regime change
