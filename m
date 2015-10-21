From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 21 Oct 2015 19:56:40 +0000
Subject: Re: [PATCH] iommu-common: fix return type of iommu_tbl_range_alloc()
Message-Id: <20151021195640.GC14667@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <55FBD36C.5070301@arm.com>
 <1442567375-6963-1-git-send-email-andre.przywara@arm.com>
 <CAMuHMdXGM0ynDSv-_MdZptXeqJ=sU7=LChmihSCoqanVTUpWXQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXGM0ynDSv-_MdZptXeqJ=sU7=LChmihSCoqanVTUpWXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On (10/21/15 21:12), Geert Uytterhoeven wrote:
> 
> Does this function really need to return DMA_ERROR_CODE in case of
> failure?

fwiw, this came up very early in code review:

  http://marc.info/?l=linux-sparc&m2613044704833&w=2

--Sowmini
