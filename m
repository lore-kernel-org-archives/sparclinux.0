From: David Miller <davem@davemloft.net>
Date: Wed, 21 Dec 2016 19:14:26 +0000
Subject: Re: [PATCH] sparc: Clean up pci mmap function.
Message-Id: <20161221.141426.1873455969093333296.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1482346624-14378-1-git-send-email-Liam.Howlett@Oracle.com>
In-Reply-To: <1482346624-14378-1-git-send-email-Liam.Howlett@Oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
Date: Wed, 21 Dec 2016 13:57:04 -0500

> Simplify logic for call to __pci_mmap_make_offset which only returns
> -EINVAL or zero and remove unnecessary if statement & variable from
> pci_mmap_page_range.
> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

This is not a legitimate simplification.  Maybe it only returns
-EINVAL as an error code now, but the whole point of returning an
explicit error code is so that in the future it can transparently be
changed to return different ones and the callers will not need
any changes.
