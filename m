From: Andi Kleen <andi@firstfloor.org>
Date: Wed, 01 Mar 2017 17:31:36 +0000
Subject: Re: [PATCH v2 1/3] sparc64: NG4 memset 32 bits overflow
Message-Id: <20170301173136.GI26852@two.firstfloor.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1488327283-177710-1-git-send-email-pasha.tatashin@oracle.com>
 <1488327283-177710-2-git-send-email-pasha.tatashin@oracle.com>
 <87h93dhmir.fsf@firstfloor.org>
 <70b638b0-8171-ffce-c0c5-bdcbae3c7c46@oracle.com>
 <20170301151910.GH26852@two.firstfloor.org>
 <6a26815d-0ec2-7922-7202-b1e17d58aa00@oracle.com>
In-Reply-To: <6a26815d-0ec2-7922-7202-b1e17d58aa00@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pasha Tatashin <pasha.tatashin@oracle.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-mm@kvack.org, sparclinux@vger.kernel.org

On Wed, Mar 01, 2017 at 11:34:10AM -0500, Pasha Tatashin wrote:
> Hi Andi,
> 
> Thank you for your comment, I am thinking to limit the default
> maximum hash tables sizes to 512M.
> 
> If it is bigger than 512M, we would still need my patch to improve

Even 512MB seems too large. I wouldn't go larger than a few tens
of MB, maybe 32MB.

Also you would need to cover all the big hashes.

The most critical ones are likely the network hash tables, these
maybe be a bit larger (but certainly also not 0.5TB) 

-Andi
