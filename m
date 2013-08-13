From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 13 Aug 2013 12:12:21 +0000
Subject: broken PCI mmap confession
Message-Id: <CACVxJT_vFSQUuRQG6-ZGw6oeD60Q9fAZUp1AWvVGVxv=FJHLzA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm sure I broke mmap(2) of PCI device proc file on sparc long ago. See:
"Fix rmmod/read/write races in /proc entries"
786d7e1612f0b0adb6046f19b906609e4fe8b1ba

Notice how it adds proxy code for ->mmap but doesn't do it for
->get_unmapped_area.

It wasn't particularly evident (read: didn't break compilation) until now
that I started to shrink /proc portion of file_operations to something smaller.

6 years passed, code still the same, noone complained (at least to me).
What should I do?
