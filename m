From: David Miller <davem@davemloft.net>
Date: Sat, 27 Dec 2008 08:56:37 +0000
Subject: Re: [PATCH 2/2] sparc: move select of ARCH_SUPPORTS_MSI
Message-Id: <20081227.005637.87929979.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081225175250.GB8613@uranus.ravnborg.org>
In-Reply-To: <20081225175250.GB8613@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 25 Dec 2008 18:52:50 +0100

> It is counter intuitive to have the select listed
> as part of the PCI option.
> Move the select to the SPARC64 specific part of the config.
> 
> PCI_MSI has a dependency on PCI so it does not harm to have
> it always selected.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Also applied, thanks Sam.
