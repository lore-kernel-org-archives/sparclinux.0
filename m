From: Eric Saint Etienne <eric.saint.etienne@oracle.com>
Date: Mon, 18 Sep 2017 14:27:45 +0000
Subject: Re: [PATCH] Expose some h/w info from ILOM to userspace via sysfs
Message-Id: <59e0a2f6-78db-0846-1f4c-72f972055e11@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
In-Reply-To: <baf0b81a-0265-ed20-52c8-e5c558f62c47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dave,

I doubt that a blob model like /dev/mdesc is better since it's not the 
approach that has been used in the kernel. You can convince yourself of 
this by looking at where lshw gets most if its data: from sysfs. That's 
because kernel developers before us (since 2.4 when sysfs has been 
introduced, really) have decided to expose things on sysfs rather then 
via blobs. So sysfs is definitely the way to go.

regards,

Eric

