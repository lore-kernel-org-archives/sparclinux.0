From: Nicolas Boullis <nboullis@debian.org>
Date: Sat, 15 May 2004 02:07:46 +0000
Subject: patch to fix XFS recovery on sparc64
Message-Id: <20040515020745.GA3359@tintin>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I guess I'm not the only one who has been hit by this bug on sparc64: on 
XFS recovery, the kernel freezes for several minutes, and then breaks in 
some semi-random way.

After much investigation, I discovered that the bug lied in the 
xfs_contig_bits function in xfs_bit.c; that function is broken on 64-bit 
big-endian architectures. The attached patch is an attempt to fix that.

Any comment about this patch? Any idea where I should try to push it?


Regards,

Nicolas

--W/nzBZO5zC0uMSeA
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="xfs.patch.gz"
Content-Transfer-Encoding: base64

H4sICPFspUACA3hmcy5wYXRjaACtVW1P40YQ/hz/ijlV7Tk4Do5JgMvhiOMKPXQUTiSolarK
cux1ssLZtdZrIFzvfntn1s4bpCpUjRInmZ15Zp552Ul4moKryku4ZUqwzC1kqWLm+u1u299v
S8Unu2mx+1B9wjHX7Xir6jMty3XdV4A2fM/rup7v+h3wuv3uQb/jt73FCxyv43mW4zgvc16j
9dxOD7y9vtfp9w420PDcOj4G1987bO354JjvHhwfW8CFtoCQYik0nxBgYZcohZ1ZlLeAfjYK
/siqn1DoSGnSalrw1XJ/4CmcnI+G4ZfT6/Di6vIXCALY8y23oZgulYCUiyQU7EGHj0xJMrTt
UhR8IlgCmRQT2GmSI7RoGD+wA/QlUxNFE/8etta8grv68x79s6xgaLu7gw/UHU0ZulSFhkhN
yhnDiLXcEgQIxpKCzsYMosyE06ogxiXaTHkB+I7ljGOIqZIzlDGTqHGZhpmchKlUs0iHGqRw
E17cVtaFVmWsW3A/5fEU4ki81eQij5IECUsFEnHUPS8YzGTCU47S+10MQ7HoFn1VKDUk+c8j
zcc843rebrehkBCjpsagQbNZLlWk5q0Fg8r4LlI8GmdYsVjmc5B3TJngkbYpaSQSKBg+9DT6
h/QskokpkCKbwzTKcyYwJQIUiwkRnWIsXL8toJygBmVNSIJDLlHSNgi7+LyTPEEs5K+wXg3q
oap0ptqhrsMKTe0D2NICqIvaBIDndoXXvJ2xWRhlmYztNYAWfP41HF6cnn4hqwbqxPncJtMW
GO5b4Gt8aorgRe1q4P5bvzqNarQgJyorZCNsUohNcMBeWsBgQOMVjq7C366ufw6Hn87PRs0l
jmJFmVHY3lKkZ/l7CzA6k6BUMVbTX8uSATCxHx0Fz/Er+3p+F2MmsFfR6sNweHo9WgvwCDYR
3WDFF36C7/blCSFjGjqV0uoQM/DkEC8Tey11X1HUQEJIcCd3HNLAQcfeNV0rxWLUZZqSjK4u
6rna6C/E/+7dUAprP+4K27hbsqHABwFUWtURhUIobwJAkCaJGhNJwyJLkRiVOvvOwtAIF0lY
ib7hB2+DjMFTRxVB8mSvWDb/J5c1tzfL8tQFrSE229J46D9TciBNHym2J20M37BFAO/c5HUL
la7N+v54wWLd0H75gt0wq1dj1+10odPre71+13u2Gl+yaLehLheu3+/1ti7czuH+QWsfHPN9
YBauBVhWYXo1eLZ4k0hHobmoljea0acX9XfVm4vaVigD8FBMWopNzHaq5yEAM6BH8PvZMDy5
OF9O95rqeK4ZBVJBbdfluGhCvBfZA82gofWu1zG03vX8mlbVx+YSDVChaSzNUjMgryC84rmd
Zi2lqNyB4kTjD/5nm4dmQ+Dw/JtexgT8uCT68dPN5WcKetPMHN+chR+vbi5H9hgnYBBYfwPb
UBxNQAoAAA==

--W/nzBZO5zC0uMSeA--
