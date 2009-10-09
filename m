From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Fri, 09 Oct 2009 14:02:14 +0000
Subject: page_to_phys
Message-Id: <4ACF4266.6000702@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Currently in io_32.h page_to_phys is defined as:

#define page_to_phys(page)	(((page) - mem_map) << PAGE_SHIFT)

Should it not be:

#define page_to_phys(page)	((((page) - mem_map) << PAGE_SHIFT) + phys_base)

or perhaps:

#define page_to_phys(page)	((dma_addr_t)page_to_pfn(page) << PAGE_SHIFT)

Best regards,
Kristoffer Glembo
