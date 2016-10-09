From: tndave <tushar.n.dave@oracle.com>
Date: Sun, 09 Oct 2016 22:47:27 +0000
Subject: Re: [linux-review:Tushar-Dave/sparc-Enable-sun4v-hypervisor-PCI-IOMMU-v2-APIs-and-ATU/20161007-13142
Message-Id: <2ee096d6-b8bb-88f3-2571-4ad7d12b926c@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5e91bce7-cf37-a078-b667-b7e58dd2717e@oracle.com>
In-Reply-To: <5e91bce7-cf37-a078-b667-b7e58dd2717e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 10/08/2016 05:50 PM, David Miller wrote:
> From: tndave <tushar.n.dave@oracle.com> Date: Sat, 8 Oct 2016
> 15:49:32 -0700
>
>> I have patches ready that resolve the warning/errors reported by
>> kbuild test robot. I will be sending v2 RFC for ATU series.
>
> I largely have no problem with this patch series, and in particular
> we were already on borrowed time wrt. making dma_addr_t 64-bit on
> sparc64.
Yeah. Thanks Dave.

A quick query: Should I include fixes for compiler warnings reported by
kbuild robot into same patch series (i.e. along with ATU) or send it
separately? Because the patches that address compiler warnings are for
network, scsi and sound drivers.

Thanks.

>
> It was a nice memory savings while it lasted :-)
:-)

-Tushar
