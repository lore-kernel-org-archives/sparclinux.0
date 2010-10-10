From: Andres Salomon <dilinger@queued.net>
Date: Sun, 10 Oct 2010 09:09:05 +0000
Subject: Re: [PATCH 1/7] sparc: make drivers/of/pdt.c no longer sparc-only
Message-Id: <20101010020905.1e27c1b4@debxo>
List-Id: <sparclinux.vger.kernel.org>
References: <20101010014358.30cb74b5@debxo>
In-Reply-To: <20101010014358.30cb74b5@debxo>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grant Likely <grant.likely@secretlab.ca>
Cc: devicetree-discuss@lists.ozlabs.org, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Whoops, that should've been 1/5, not 1/7.  Two additional x86 patches
snuck in there that are already in Grant's test-devicetree branch.


On Sun, 10 Oct 2010 01:43:58
-0700 Andres Salomon <dilinger@queued.net> wrote:

> 
> Clean up pdt.c:
>  - make build dependent upon config OF_PROMTREE
>  - #ifdef out the sparc-specific stuff
>  - create pdt-specific header
> 
> Signed-off-by: Andres Salomon <dilinger@queued.net>
