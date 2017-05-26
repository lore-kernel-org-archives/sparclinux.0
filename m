From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 26 May 2017 15:51:38 +0000
Subject: Re: [PATCH v3 0/5] LDC changes for porting VCC driver into upstream kernel
Message-Id: <647ADE85-B8B0-4B88-B743-949228D6AE86@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1495721691.git.jag.raman@oracle.com>
In-Reply-To: <cover.1495721691.git.jag.raman@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


> On May 26, 2017, at 1:41 AM, Christoph Hellwig <hch@infradead.org> wrote:
> 
> On Thu, May 25, 2017 at 10:25:53AM -0400, Jag Raman wrote:
>> This series of patches is part of an effort to add VCC (Virtual Channel
>> Concentrator) and VDS (Virtual Disk Server) support to Linux.
> 
> Can you please sned pointers to these drivers along to review your
> changes?

The drivers are planned to be sent out for review 3 or 4 patch series down the line. It wouldn't compile if the driver was sent out right after this patch.

The plan is to gradually add APIs/changes that would satisfy the dependency for the drivers, before they are finally consumed by the drivers.

>  In general new exports should go along with their users.

Would it be alright if these APIs could be defined but not exported until consumed?

> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

