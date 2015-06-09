From: James Y Knight <jyknight@google.com>
Date: Tue, 09 Jun 2015 21:54:10 +0000
Subject: Re: Linux Sparc FPU register corruption
Message-Id: <513253DE-8B73-4956-BE1F-49B714615563@google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
In-Reply-To: <49B61131-8512-493B-BF49-7B2362383CCF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Jun 9, 2015, at 3:02 PM, David Miller <davem@davemloft.net> wrote:
> Anyways, please put proper memory barriers into your testcase and
> let's see if the problem still triggers.

Okay, I edited my test case changing the asm to "membar #Sync; stda %%f0, [%0] 0xf0; membar #Sync". That should be entirely over-doing it, right? Problem still occurs within seconds.

And, don't forget Problem #2 -- which didn't even involve weird ASIs at all (at least, not in the test task itself).

On Jun 9, 2015, at 4:45 PM, David Miller <davem@davemloft.net> wrote:
> Just FYI, I commented out the usleep() in your test program and have
> been running your:
> 
> seq 64 | xargs -n1 -P64 /bin/sh -c 'while ./a.out; do : ; done'
> 
> test, and it's been running flawlessly for 2 hours on my T4.
> 
> This is with Linus's current tree.
> 
> I'll fire up my T3 later and try to reproduce it there.

Gah! Thanks for testing it on your setup!...but that's really unfortunate that you can't reproduce the problem!

What distro are you running? Maybe I should try the same thing you're using...

Anyone else reading this able to reproduce problems with my test program (or not?)