From: David Miller <davem@davemloft.net>
Date: Tue, 21 Jan 2014 22:35:13 +0000
Subject: Re: [PATCH 23/73] sparc: don't use module_init in non-modular pci.c code
Message-Id: <20140121.143513.90426024063083999.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
	<1390339396-3479-24-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1390339396-3479-24-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: paul.gortmaker@windriver.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, bhelgaas@google.com, sparclinux@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 21 Jan 2014 16:22:26 -0500

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
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

ACK
