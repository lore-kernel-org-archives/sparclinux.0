From: David Miller <davem@davemloft.net>
Date: Wed, 29 Nov 2017 19:26:44 +0000
Subject: Re: sparc64: git kernel 4.14.0-12995-g0c86a6bd85ff does not boot
Message-Id: <20171129.142644.2300740097087344385.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
In-Reply-To: <CADxRZqxRB=G4+QwYasS0a7GJA-4WJW13NQTm-oEt8QrHgZixSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 29 Nov 2017 21:58:21 +0300

> On Wed, Nov 29, 2017 at 9:48 PM, David Miller <davem@davemloft.net> wrote:
>>
>> We are initializing free memory, then we end up at a totally unrelated
>> piece of code.
>>
>> Something is causing the cpu to call some random address and we need
>> to figure out why.
>>
>> I've built the current kernel on a SunBlade-2500 with gcc-4.4.5 and I
>> couldn't reproduce this crash.
> 
> David, using your git sparc kernel tree, bisect log:
> 
> mator@ttip:~/sparc$ git remote -v
> origin  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git (fetch)
> origin  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git (push)
> 
> mator@ttip:~/sparc$ git bisect good
> 46ad8d2d22c17e2b577adec55ae87161666a3267 is the first bad commit
> commit 46ad8d2d22c17e2b577adec55ae87161666a3267
> Author: Vijay Kumar <vijay.ac.kumar@oracle.com>
> Date:   Wed Oct 11 12:50:06 2017 -0600
> 
>     sparc64: Use sparc optimized fls and __fls for T4 and above

Thanks for bisecting, I'll take a look.
