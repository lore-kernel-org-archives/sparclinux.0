From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 02 Mar 2017 19:15:34 +0000
Subject: Re: [PATCH v2 1/3] sparc64: NG4 memset 32 bits overflow
Message-Id: <219d73df-3620-b7ed-7b3d-b1612435a9ff@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1488327283-177710-1-git-send-email-pasha.tatashin@oracle.com>
 <1488327283-177710-2-git-send-email-pasha.tatashin@oracle.com>
 <87h93dhmir.fsf@firstfloor.org>
 <70b638b0-8171-ffce-c0c5-bdcbae3c7c46@oracle.com>
 <20170301151910.GH26852@two.firstfloor.org>
 <6a26815d-0ec2-7922-7202-b1e17d58aa00@oracle.com>
 <20170301173136.GI26852@two.firstfloor.org>
 <1e7db21b-808d-1f47-e78c-7d55c543ae39@oracle.com>
 <20170301231025.GJ26852@two.firstfloor.org>
In-Reply-To: <20170301231025.GJ26852@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org

Hi Andi,

>
> I think a upper size (with user override which already exists) is fine,
> but if you really don't want to do it then scale the factor down
> very aggressively for larger sizes, so that we don't end up with more
> than a few tens of MB.
>

I have scaled it, I do not think setting a default upper limit is a 
future proof strategy.

Thank you,
Pasha
