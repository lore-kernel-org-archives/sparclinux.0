From: Bob Picco <bpicco@meloft.net>
Date: Thu, 16 Oct 2014 12:36:54 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141016123654.GI22365@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Tue Oct 14 2014, 10:40:28PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Sun, 12 Oct 2014 23:53:09 -0400 (EDT)
> 
> > Anyways I'll dig further and fix this.
> 
> Bob, I am putting the following fix through some tests, I'll
> commit and push everywhere after my tests complete.
> 
> Let me know if it works for you too, it should make that bootup
> AES test faulure disappear.
> 
> Thanks!
You're welcome. Thanx for the splendid changelog! Otherwise time reviewing
the fpu paths and etc. would have been a challenge to schedule. Boots and
tests without issue on T5-2. Though I had configure them in and 
# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
. I did review the patch modifications too.
