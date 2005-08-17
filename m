From: Josh Grebe <josh@brokedown.net>
Date: Wed, 17 Aug 2005 13:06:06 +0000
Subject: Re: 2.4 kernels and max # of rules with iptables
Message-Id: <4303363E.80503@brokedown.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050619200712.036920e1@enterprise.weeve.org>
In-Reply-To: <20050619200712.036920e1@enterprise.weeve.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Good Morning,

I threw a little printk patch at Jason and we determined that to be 
correct. In do_netfilter_replace(), on about line 2924, the call
        krepl = (struct ipt_replace *)kmalloc(kreplsize, GFP_KERNEL);
results in krepl being NULL after a pile of rules have been added.

I compiled a statically linked iptables binary and Jason was able to 
add over 7k rules before he stopped it, the 32 bit iptables bombs 
before 900 rules.

As far as changing this behaviour, I plead ignorance.

Thanks,

Josh


Jason Wever wrote:
> On Sun, 19 Jun 2005 19:20:34 -0700 (PDT)
> "David S. Miller" <davem@davemloft.net> wrote:
> 
> 
>>64-bit or 32-bit userland binaries?
> 
> 
> 32 bit userland binaries.  Currently we don't have a working 64 bit
> environment that is suggested for general use.
>  
> 
>>He could be hitting the kmalloc() limit via the netfilter
>>32-bit userland compat code in:
>>
>>       arch/sparc64/kernel/sys_sparc32.c:do_netfilter_replace()
>>
