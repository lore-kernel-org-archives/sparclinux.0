From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 05:15:39 +0000
Subject: Re: [PATCH 7/7] sparc: unify openprom.h
Message-Id: <20090102.211539.66135116.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1230840190-31884-7-git-send-email-sam@ravnborg.org>
In-Reply-To: <1230840190-31884-7-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu,  1 Jan 2009 21:03:10 +0100

> After the preparational steps the unification was simple.
> 
> The linux_prom_pci_registers definition did not look like
> it could be unified at first look sine the structure is assigned
> using prop_getproperty() / of_get_property() so the structure
> is assumed to come direct form the prom.
> 
> The LINUX_OPPROM_MAGIC was kept even if it is not used by the kernel
> on the assumption that userspace may require it.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Also applied, thanks a lot Sam.
