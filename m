From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 03 Mar 2005 02:00:48 +0000
Subject: Re: [PATCH] sparc: fix compile failure ("struct resource" related)
Message-Id: <20050303020048.GU15648@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200503012129.11840.adobriyan@mail.ru> <20050301134440.05ae1152.akpm@osdl.org>
In-Reply-To: <20050301134440.05ae1152.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Alexey Dobriyan <adobriyan@mail.ru>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 01:44:40PM -0800, Andrew Morton wrote:
> Thanks.  Many of these fixups are due to a 64-bit-resource patch in Greg's
> bk-pci tree which he has now reverted.  That being said:
> - That patch will come back sometime
> - Fixes like the below make sense anyway and can be merged any time.
> - All the fixes which were only applicable when the 64-bit-resource patch
>   is present have been sent to Greg for when that patch reemerges.

Well, in isolation it's a C99 initializer cleanup, which is good.

Acked-by: William Irwin <wli@holomorphy.com>


-- wli
