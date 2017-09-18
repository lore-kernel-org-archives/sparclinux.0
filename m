From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Mon, 18 Sep 2017 14:23:57 +0000
Subject: Re: [PATCH] sparc64: Expose mdesc to sysfs
Message-Id: <b5f5de3d-f93e-b80b-c902-74dfc2700061@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
In-Reply-To: <201709160508.v8G58BRq011742@aserv0022.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thanks for the quick feedback, Dave.

Buses like PCI or USB as well as other data types are exposed in sysfs, 
not via blobs like /dev/mdesc.

Sysfs has a neat tree structure that allows to discover and browse the 
system structure. In contrast a binary blob like /dev/mdesc requires 
interpretation via a script.

The aim of this patch is to ease browsing mdesc and implement utilities 
like lshw. If you look at lshw sources, you'll see that they make a real 
huge use of sysfs, the only binary device they use is for DMI tables 
(via /dev/dmi if present, or by directly accessing mmap'ed physical 
memory otherwise)

Also, since mdesc is basically a tree it maps well to a filesystem 
structure like sysfs.

thank you.

-eric
