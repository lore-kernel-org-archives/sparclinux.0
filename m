From: alexmcwhirter@triadic.us
Date: Thu, 28 Jul 2016 01:27:05 +0000
Subject: Re: [PATCH] sparc: Don't leak context bits into =?UTF-8?Q?thread-=3Efault=5Faddress?=
Message-Id: <290dd0f4ce5fd9897e16d701f91adce9@triadic.us>
List-Id: <sparclinux.vger.kernel.org>
References: <20160727.175351.219584019615190125.davem@davemloft.net>
In-Reply-To: <20160727.175351.219584019615190125.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 2016-07-27 20:53, David Miller wrote:
> On pre-Niagara systems, we fetch the fault address on data TLB
> exceptions from the TLB_TAG_ACCESS register.  But this register also
> contains the context ID assosciated with the fault in the low 13 bits
> of the register value.
> 
> This propagates into current_thread_info()->fault_address and can
> cause trouble later on.
> 
> So clear the low 13-bits out of the TLB_TAG_ACCESS value in the cases
> where it matters.

I'm going to go ahead and give this patch a test on an E6K, i'll report 
my findings later tonight.

