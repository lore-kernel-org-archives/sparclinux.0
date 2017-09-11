From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon, 11 Sep 2017 23:28:19 +0000
Subject: Re: [PATCH] sparc64: Oracle DAX infrastructure
Message-Id: <fe854e7a-5fc7-b3a2-0a29-72b91277cf52@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1505169129-36547-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 09/11/2017 04:55 PM, David Miller wrote:
> From: Rob Gardner <rob.gardner@oracle.com>
> Date: Mon, 11 Sep 2017 16:32:09 -0600
>
>> This patch adds hypercall function stubs and C templates for
>> ccb_submit/info/kill which provide coprocessor services for the Oracle
>> Data Analytics Accelerator, registration for the DAX api group, and
>> all the various associated constants.
>>
>> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
>> Signed-off-by: Jonathan Helman <jonathan.helman@oracle.com>
>> Signed-off-by: Sanath Kumar <sanath.s.kumar@oracle.com>
> Please resubmit inside of a patch series containing the first
> consumer of these interfaces.
>
> Without an example usage, it's essentialy impossible to properly
> review.

The stubs/templates/constants reflect the hypervisor APIs, so there is 
not very much flexibility in how these are done.

The first consumer of these interfaces you have seen in the RFC we sent 
out a week or two ago. Would it be possible for you to give us some 
feedback about the form you would like this consumer to take, if not the 
one we've provided? Again, since the interfaces to the coprocessor are 
defined by the hypervisor, we don't have a lot of leeway in how we go 
about providing coprocessor services to applications. We thought the 
simplest path would be to provide pure mechanism, and leave all the work 
to the user library. The library is huge and it would be highly 
impractical to incorporate it into the kernel. Incidentally, we said the 
library would be open sourced, and this has been done:
     https://oss.oracle.com/git/gitweb.cgi?p=libdax.git

Thank you.

