From: David Miller <davem@davemloft.net>
Date: Thu, 24 Dec 2015 16:39:40 +0000
Subject: Re: [PATCH v2] sparc64: Add ADI capability to cpu capabilities
Message-Id: <20151224.113940.52819657864430289.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1450373630-6916-1-git-send-email-khalid.aziz@oracle.com>
In-Reply-To: <1450373630-6916-1-git-send-email-khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khalid.aziz@oracle.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Thu, 17 Dec 2015 10:33:50 -0700

> Add ADI (Application Data Integrity) capability to cpu capabilities list.
> ADI capability allows virtual addresses to be encoded with a tag in
> bits 63-60. This tag serves as an access control key for the regions
> of virtual address with ADI enabled and a key set on them. Hypervisor
> encodes this capability as "adp" in "hwcap-list" property in machine
> description.
> 
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> ---
> v2:
> 	- Removed string translation of capability from "adp" to "adi"

Applied.
