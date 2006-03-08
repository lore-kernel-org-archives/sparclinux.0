From: Richard Mortimer <richm@oldelvet.org.uk>
Date: Wed, 08 Mar 2006 21:54:54 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <1141854894.5815.165.camel@duncow>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 2006-03-08 at 14:33 -0600, Josh Grebe wrote:
> Full dmesg log is at: http://dev.gentoo.org/~squash/v240-3.txt
> 
> I'll now give you the entire first error per CPU as well as the System.map
> functions summary for all of them. There are a bunch of duplicates, which
> I'll include for completeness but only give the function name the first
> time. Hopefully this is a complete enough report for you.

I'm not sure if you noticed this (but neither you or Dave mentioned it)
so I'll mention it. But there is an earlier error in your log...

[   13.886016] BUG: spinlock wrong CPU on CPU#1, swapper/0
[   13.886023]  lock: 00000000006bfa40, .magic: dead4ead, .owner: swapper/0, .owner_cpu: 0
[   13.886029] Call Trace:
[   13.886034]  [00000000006cc838] start_kernel+0x1d8/0x200
[   13.886050]  [00000000004043f4] tlb_fixup_done+0x5c/0x64
[   13.886060]  [0000000000000000] _start+0xffffffffffbfc000/0x12

Could that have been the start of things going wrong?

Richard

-- 
Richard Mortimer <richm@oldelvet.org.uk>

