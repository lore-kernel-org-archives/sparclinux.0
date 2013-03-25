From: David Miller <davem@davemloft.net>
Date: Mon, 25 Mar 2013 22:14:07 +0000
Subject: Re: [PATCH 2/3] sparc/iommu: use BITS_TO_LONGS() to calculate bitmap size
Message-Id: <20130325.181407.623756754932684053.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1364115306-17716-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1364115306-17716-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 26 Mar 2013 09:11:15 +1100

> On Sun, Mar 24, 2013 at 7:55 PM, Akinobu Mita <akinobu.mita@gmail.com> wrote:
>> @@ -34,7 +34,7 @@
>>  #define IOMMU_RNGE     IOMMU_RNGE_256MB
>>  #define IOMMU_START    0xF0000000
>>  #define IOMMU_WINSIZE  (256*1024*1024U)
>> -#define IOMMU_NPTES    (IOMMU_WINSIZE/PAGE_SIZE)       /* 64K PTEs, 265KB */
>> +#define IOMMU_NPTES    (IOMMU_WINSIZE/PAGE_SIZE)       /* 64K PTEs, 256KB */
> 
> Is this change worthwhile?

It's a comment typo fix, so sure why not.
