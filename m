From: David Miller <davem@davemloft.net>
Date: Wed, 29 Jan 2014 07:39:06 +0000
Subject: Re: [PATCH] sparc: don't use module_init in non-modular pci.c code
Message-Id: <20140128.233906.165357673105335071.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1389550050-17936-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1389550050-17936-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Sun, 12 Jan 2014 13:07:30 -0500

> The pci.o is built for SPARC64_PCI -- which is bool, and hence
> this code is either present or absent.  It will never be modular,
> so using module_init as an alias for __initcall can be somewhat
> misleading.
> 
> Fix this up now, so that we can relocate module_init from
> init.h into module.h in the future.  If we don't do this, we'd
> have to add module.h to obviously non-modular code, and that
> would be a worse thing.
> 
> Note that direct use of __initcall is discouraged, vs. one
> of the priority categorized subgroups.  As __initcall gets
> mapped onto device_initcall, our use of device_initcall
> directly in this change means that the runtime impact is
> zero -- it will remain at level 6 in initcall ordering.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Also applied, thanks Paul.
