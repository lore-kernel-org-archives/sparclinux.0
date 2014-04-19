From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 19 Apr 2014 18:17:03 +0000
Subject: Re: Fwd: Time to let sun4m + sun4d RIP?
Message-Id: <20140419181703.GA15050@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <CALMQjD96AqwOpiSifwBCG_S_kU_yANh1Ja2W2XAG2d6jW6dgBA@mail.gmail.com>
In-Reply-To: <CALMQjD96AqwOpiSifwBCG_S_kU_yANh1Ja2W2XAG2d6jW6dgBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> Is there currently some technical difficulties that prevents us for
> keeping the status quo? Or
> is this just a suggestion for the sake of suggestions ?

sun4m + sun4d is a significant part of the sparc32 architecture.
Some quick hacking revealed the following numbers:
> 16 files changed, 28 insertions(+), 2958 deletions(-)

There are more to come after if we go this route.

The stuff I have on the todo list for sparc32 are (in no particular order):
- Fix to we map memory correct durign startup.
  We need to find a way so we map memory such that we
  do not hit the current limitation where things goes wrong
  after the kernel becomes slightly too big.
- introduce memblock (i have something halfway done, but it fails due to the
  memory mapping problem. And it did not support highmem)
- use proper of_ function for floppy
- analyze what can be shared with sparc64, there seems to be more
  shareable code than what we have today. Especially during startup.
- cpu_data.counter is used to display number of NMI interrupts in arch_show_interrupt
  - this is plain wrong. We do not have any NMI counter on sparc32
- make more sparc drivers buildable on x86 - to get better build coverage
- address some of the sparse generated warnings - try to get down to 100 for arch/sparc/
- get qemu running to ease testing (not kernel related)

And there are probarly more when I start surfing the code again.

The above becomes easier when there are less code to
understand, change and eventuelly test.

	Sam
