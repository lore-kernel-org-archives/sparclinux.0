From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon, 07 Mar 2016 23:12:03 +0000
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity (ADI)
Message-Id: <56DE0AC3.9070503@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <56DDC2B6.6020009@oracle.com> <56DDC3EB.8060909@oracle.com>
 <56DDC776.3040003@oracle.com>
 <20160307.141600.1873883635480850431.davem@davemloft.net>
 <56DDF3C4.7070701@oracle.com>
In-Reply-To: <56DDF3C4.7070701@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Khalid Aziz <khalid.aziz@oracle.com>, David Miller <davem@davemloft.net>
Cc: corbet@lwn.net, akpm@linux-foundation.org, dingel@linux.vnet.ibm.com, bob.picco@oracle.com, kirill.shutemov@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, arnd@arndb.de, sparclinux@vger.kernel.org, mhocko@suse.cz, chris.hyser@oracle.com, richard@nod.at, vbabka@suse.cz, koct9i@gmail.com, oleg@redhat.com, gthelen@google.com, jack@suse.cz, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, luto@kernel.org, ebiederm@xmission.com, bsegall@google.com, geert@linux-m68k.org, dave@stgolabs.net, adobriyan@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

On 03/07/2016 01:33 PM, Khalid Aziz wrote:
>
> That is a possibility but limited in scope. An address range covered 
> by a single TTE can have large number of tags. Version tags are set on 
> cacheline. In extreme case, one could set a tag for each set of 
> 64-bytes in a page. Also tags are set completely in userspace and no 
> transition occurs to kernel space, so kernel has no idea of what tags 
> have been set.

   ...
> I have not found a way to query the MMU on tags.
>

To query the tag for a cache line, you just read it back with ldxa and 
ASI_MCD_PRIMARY (ie, asi 0x90), basically the same way you stored the 
tag in the first place.

Rob



