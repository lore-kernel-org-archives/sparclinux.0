From: tndave <tushar.n.dave@oracle.com>
Date: Mon, 10 Oct 2016 04:20:35 +0000
Subject: Re: [linux-review:Tushar-Dave/sparc-Enable-sun4v-hypervisor-PCI-IOMMU-v2-APIs-and-ATU/20161007-13142
Message-Id: <5482118b-622d-9199-b5cb-39dab8e59f99@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <5e91bce7-cf37-a078-b667-b7e58dd2717e@oracle.com>
In-Reply-To: <5e91bce7-cf37-a078-b667-b7e58dd2717e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 10/09/2016 06:04 PM, David Miller wrote:
> From: tndave <tushar.n.dave@oracle.com>
> Date: Sun, 9 Oct 2016 15:47:27 -0700
>
>> A quick query: Should I include fixes for compiler warnings reported
>> by kbuild robot into same patch series (i.e. along with ATU) or send
>> it separately? Because the patches that address compiler warnings
>> are for network, scsi and sound drivers.
>
> Since it covers other subsystems probably best to submit it separately
> to those individual subsystems.
Ok, will do. Thanks.

-Tushar
>
> Thanks.
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
