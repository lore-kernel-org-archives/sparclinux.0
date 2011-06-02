From: william felipe_welter <wfelipew@gmail.com>
Date: Thu, 02 Jun 2011 15:47:50 +0000
Subject: Re: mmap operation not working as expected on sparc linux
Message-Id: <BANLkTinivZes36--eWz_RGnJ8kDpSB2Y4w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DE5F5B9.4020601@redhat.com>
In-Reply-To: <4DE5F5B9.4020601@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> http://en.wikipedia.org/wiki/Ring_buffer#Exemplary_POSIX_Implementation
>
> This doesn't appear to work on sparclinux, returning an error EINVAL  on
> the second memory map operation:
>
> address = mmap (buffer->address + buffer->count_bytes,
>                   buffer->count_bytes, PROT_READ | PROT_WRITE,
>                   MAP_FIXED | MAP_SHARED, file_descriptor, 0);
>
> Any ideas?

Steven the problem are on the second mmap, this is the third call to mmap...


First call:
buffer->address = mmap (NULL, buffer->count_bytes << 1, PROT_NONE,
                          MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);

Second call (where the problem occurs, returns 0xffffffff):
address =    mmap (buffer->address, buffer->count_bytes, PROT_READ | PROT_WRITE,
          MAP_FIXED | MAP_SHARED, file_descriptor, 0);

Third (is not called because the error of the second) :
 address = mmap (buffer->address + buffer->count_bytes,
                  buffer->count_bytes, PROT_READ | PROT_WRITE,
                  MAP_FIXED | MAP_SHARED, file_descriptor, 0);


Some ideas ? What can be the reason of this behavior ?


-- 
William Felipe Welter
------------------------------
Consultor em Tecnologias Livres
william.welter@4linux.com.br
www.4linux.com.br
