From: David Miller <davem@davemloft.net>
Date: Tue, 08 Mar 2016 04:13:03 +0000
Subject: Re: [PATCH v2] sparc64: Add support for Application Data Integrity (ADI)
Message-Id: <20160307.231303.1411773963750082733.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <56DDF3C4.7070701@oracle.com>
	<20160307.163850.1494834587897617780.davem@davemloft.net>
	<56DE0B1B.1000000@oracle.com>
In-Reply-To: <56DE0B1B.1000000@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: rob.gardner@oracle.com
Cc: khalid.aziz@oracle.com, corbet@lwn.net, akpm@linux-foundation.org, dingel@linux.vnet.ibm.com, bob.picco@oracle.com, kirill.shutemov@linux.intel.com, aneesh.kumar@linux.vnet.ibm.com, aarcange@redhat.com, arnd@arndb.de, sparclinux@vger.kernel.org, mhocko@suse.cz, chris.hyser@oracle.com, richard@nod.at, vbabka@suse.cz, koct9i@gmail.com, oleg@redhat.com, gthelen@google.com, jack@suse.cz, xiexiuqi@huawei.com, Vineet.Gupta1@synopsys.com, luto@kernel.org, ebiederm@xmission.com, bsegall@google.com, geert@linux-m68k.org, dave@stgolabs.net, adobriyan@gmail.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-api@vger.kernel.org

From: Rob Gardner <rob.gardner@oracle.com>
Date: Mon, 7 Mar 2016 15:13:31 -0800

> You can easily read ADI tags with a simple ldxa #ASI_MCD_PRIMARY
> instruction.

Awesome!
