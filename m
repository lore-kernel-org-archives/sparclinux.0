From: Pasha Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 01 Mar 2017 21:20:28 +0000
Subject: Re: [PATCH v2 1/3] sparc64: NG4 memset 32 bits overflow
Message-Id: <1e7db21b-808d-1f47-e78c-7d55c543ae39@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1488327283-177710-1-git-send-email-pasha.tatashin@oracle.com>
 <1488327283-177710-2-git-send-email-pasha.tatashin@oracle.com>
 <87h93dhmir.fsf@firstfloor.org>
 <70b638b0-8171-ffce-c0c5-bdcbae3c7c46@oracle.com>
 <20170301151910.GH26852@two.firstfloor.org>
 <6a26815d-0ec2-7922-7202-b1e17d58aa00@oracle.com>
 <20170301173136.GI26852@two.firstfloor.org>
In-Reply-To: <20170301173136.GI26852@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org

Hi Andi,

After thinking some more about this issue, I figured that I would not 
want to set default maximums.

Currently, the defaults are scaled with system memory size, which seems 
like the right thing to do to me. They are set to size hash tables one 
entry per page and, if a scale argument is provided, scale them down to 
1/2, 1/4, 1/8 entry per page etc.

So, in some cases the scale argument may be wrong, and dentry, inode, or 
some other client of alloc_large_system_hash() should be adjusted.

For example, I am pretty sure that scale value in most places should be 
changed from literal value (inode scale = 14, dentry scale = 13, etc to: 
(PAGE_SHIFT + value): inode scale would become (PAGE_SHIFT + 2), dentry 
scale would become (PAGE_SHIFT + 1), etc. This is because we want 1/4 
inodes and 1/2 dentries per every page in the system.
In alloc_large_system_hash() we have basically this:
nentries = nr_kernel_pages >> (scale - PAGE_SHIFT);

This is basically a bug, and would not change the theory, but I am sure 
that changing scales without at least some theoretical backup is not a 
good idea and would most likely lead to regressions, especially on some 
smaller configurations.

Therefore, in my opinion having one fast way to zero hash tables, as 
this patch tries to do, is a good thing. In the next patch revision I 
can go ahead and change scales to be (PAGE_SHIFT + val) from current 
literals.

Thank you,
Pasha

On 2017-03-01 12:31, Andi Kleen wrote:
> On Wed, Mar 01, 2017 at 11:34:10AM -0500, Pasha Tatashin wrote:
>> Hi Andi,
>>
>> Thank you for your comment, I am thinking to limit the default
>> maximum hash tables sizes to 512M.
>>
>> If it is bigger than 512M, we would still need my patch to improve
>
> Even 512MB seems too large. I wouldn't go larger than a few tens
> of MB, maybe 32MB.
>
> Also you would need to cover all the big hashes.
>
> The most critical ones are likely the network hash tables, these
> maybe be a bit larger (but certainly also not 0.5TB)
>
> -Andi
>

