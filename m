From: David Miller <davem@davemloft.net>
Date: Mon, 12 Dec 2016 02:19:12 +0000
Subject: Re: [PATCH] sparc64: fix typo in pgd_clear()
Message-Id: <20161211.211912.738337085233535734.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20161209112400.72500-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20161209112400.72500-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Fri,  9 Dec 2016 14:24:00 +0300

> It really has to be pgdp, not pgd.
> 
> It just happend to work since all callers have 'pgd' as an argument.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Applied.
