From: David Miller <davem@davemloft.net>
Date: Mon, 28 Oct 2019 23:09:11 +0000
Subject: Re: [PATCH v5 1/4] sparc64: implement ioremap_uc
Message-Id: <20191028.160911.1021429466798996209.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20191016210629.1005086-2-ztuowen@gmail.com>
        <5c5b9dec7ea401fffa13446af2a528cbaf6e1046.camel@gmail.com>
In-Reply-To: <5c5b9dec7ea401fffa13446af2a528cbaf6e1046.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ztuowen@gmail.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, acelan.kao@canonical.com, mcgrof@kernel.org

From: Tuowen Zhao <ztuowen@gmail.com>
Date: Mon, 28 Oct 2019 14:46:00 -0600

> Adding sparc list. Sorry, first time missed the list.
> 
> Looking for some reviews.
> 
> Patch set: Fix MTRR bug for intel-lpss-pci
> https://lkml.org/lkml/2019/10/16/1230
> 
> Tuowen
> 
> -------- Forwarded Message --------
> From: Tuowen Zhao <ztuowen@gmail.com>
> To: lee.jones@linaro.org, linux-kernel@vger.kernel.org
> Cc: andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
> acelan.kao@canonical.com, mcgrof@kernel.org, davem@davemloft.net, 
> Tuowen Zhao <ztuowen@gmail.com>, kbuild test robot <lkp@intel.com>
> Subject: [PATCH v5 1/4] sparc64: implement ioremap_uc
> Date: Wed, 16 Oct 2019 15:06:27 -0600
> 
> On sparc64, the whole physical IO address space is accessible using
> physically addressed loads and stores. *_uc does nothing like the
> others.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
