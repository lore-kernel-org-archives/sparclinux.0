From: Steven Dake <sdake@redhat.com>
Date: Wed, 01 Jun 2011 08:18:01 +0000
Subject: mmap operation not working as expected on sparc linux
Message-Id: <4DE5F5B9.4020601@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I maintain a project called corosync which uses a memory backed file to
generate a duplicate mapping in memory to implement a ring buffer.  It
essentially uses the concepts here:

http://en.wikipedia.org/wiki/Ring_buffer#Exemplary_POSIX_Implementation

This doesn't appear to work on sparclinux, returning an error EINVAL  on
the second memory map operation:

address = mmap (buffer->address + buffer->count_bytes,
                  buffer->count_bytes, PROT_READ | PROT_WRITE,
                  MAP_FIXED | MAP_SHARED, file_descriptor, 0);

Any ideas?

Thanks
-steve
