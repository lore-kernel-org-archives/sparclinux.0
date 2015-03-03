From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 03 Mar 2015 14:33:36 +0000
Subject: Re: [PATCH 1/2] Break up monolithic iommu table/lock into finer graularity pools and lock
Message-Id: <20150303143336.GA8361@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20141222224321.GI29674@oracle.com>
In-Reply-To: <20141222224321.GI29674@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Please rewrite this so that only the truly generic stuff, which is
> %100 agnostic to IOMMU design or architecutre, goes into the new
> "generic" code.

I just remembered that I forgot to note the changes since V1 in 
each patch of the V2 version of the set that I just sent out,
though I have a detailed description in the cover letter. 

Sorry about that. I can send out v3, if a description of the
per-patch deltas are needed.

--Sowmini


