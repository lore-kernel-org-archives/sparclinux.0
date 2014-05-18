From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Date: Sun, 18 May 2014 13:52:55 +0000
Subject: format string mismatch in arch/sparc/kernel/sysfs.c
Message-Id: <5378BB37.2000402@gmx.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I'm just wondering if the format mismatch error is intentionally left in the code or not :

[arch/sparc/kernel/sysfs.c:154]: (warning) %ld in format string (no. 1) requires 'long *' but the argument type is 'unsigned long *'.


8a25a2fd arch/sparc/kernel/sysfs.c   (Kay Sievers      2011-12-21 14:29:42 -0800 149) static ssize_t store_mmustat_enable(struct device *s,
8a25a2fd arch/sparc/kernel/sysfs.c   (Kay Sievers      2011-12-21 14:29:42 -0800 150)                   struct device_attribute *attr, const char *buf,
4a0b2b4d arch/sparc64/kernel/sysfs.c (Andi Kleen       2008-07-01 18:48:41 +0200 151)                   size_t count)
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 152) {
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 153)   unsigned long val, err;
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 154)   int ret = sscanf(buf, "%ld", &val);               <--------------
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 155)
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 156)   if (ret != 1)
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 157)           return -EINVAL;
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 158)
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 159)   err = run_on_cpu(s->id, write_mmustat_enable, val);
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 160)   if (err)
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 161)           return -EIO;
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 162)
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 163)   return count;
d887ab3a arch/sparc64/kernel/sysfs.c (David Miller     2007-06-03 23:38:09 -0700 164) }

-- 
Toralf

