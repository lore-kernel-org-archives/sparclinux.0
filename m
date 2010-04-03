From: David Miller <davem@davemloft.net>
Date: Sat, 03 Apr 2010 20:58:03 +0000
Subject: Re: [PATCH] sparc64: Fix array size reported by vmemmap_populate()
Message-Id: <20100403.135803.268413025.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1270327280.12516.368.camel@localhost>
In-Reply-To: <1270327280.12516.368.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Sat, 03 Apr 2010 13:50:29 -0700 (PDT)

> From: Ben Hutchings <ben@decadent.org.uk>
> Date: Sat, 03 Apr 2010 21:41:20 +0100
> 
>> vmemmap_populate() attempts to report the used index and total size of
>> vmemmap_table, but it wrongly shifts the total size so that it is
>> always shown as 0.
>> 
>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> 
> It's not the total, size, it's the total number of chunks that
> the area supports.

Nevermind, Ben's patch is right, I'll apply it.

VMEMMAP_SIZE is number of entries, not a size in bytes.

Further confusing things is that before the VMEMMAP_SIZE
bug fix the other month, the calculation was "correct"
:-)
