From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 28 Apr 2015 10:49:07 +0000
Subject: Re: [PATCH RFC 1/1] sparc64: pci slots information is not populated in sysfs
Message-Id: <CAGRGNgXk+LT+zXbR-Kiep3z2LXWioXmjojCS_OhPjpHyjPzo=g@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="047d7b87472ce2db7d0514c69d9b"
List-Id: <sparclinux.vger.kernel.org>
References: <1430172435-231374-1-git-send-email-eric.snowberg@oracle.com>
In-Reply-To: <1430172435-231374-1-git-send-email-eric.snowberg@oracle.com>
To: sparclinux@vger.kernel.org

--047d7b87472ce2db7d0514c69d9b
Content-Type: text/plain; charset=UTF-8

Hi Eric,

On Tue, Apr 28, 2015 at 8:07 AM, Eric Snowberg <eric.snowberg@oracle.com> wrote:
> Add PCI slot numbers within sysfs for sun4v hardware. Larger
> sun4v systems contain nested PCI bridges and slots further
> down on these bridges were not being populated within sysfs.
> Also add AHCI style PCI slot numbers within sysfs for sun4v
> hardware since the OF 'slot-names' information is not available
> on all sun4v platforms.
>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> ---
>  arch/sparc/kernel/pci.c |   37 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 37 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index 6f7251f..3a5c402 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -1054,6 +1086,11 @@ static int __init of_pci_slot_init(void)
>         while ((pbus = pci_find_next_bus(pbus)) != NULL) {
>                 struct device_node *node;
>
> +               if (tlb_type == hypervisor) {
> +                       pci_sun4v_bus_slot_names(pbus);
> +                       continue;
> +               }
> +

One last thing: would it be worth it to put the following before the
while loop instead of having the test inside it? I dislike invariant
tests in loops. (Incremental patch attached)

+        if (tlb_type == hypervisor) {
+                while ((pbus = pci_find_next_bus(pbus)) != NULL)
+                        pci_sun4v_bus_slot_names(pbus);
+
+                return 0;
+        }

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/

--047d7b87472ce2db7d0514c69d9b
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-sparc64-pci-Move-hypervisor-test-out-of-loop.patch"
Content-Disposition: attachment; 
	filename="0001-sparc64-pci-Move-hypervisor-test-out-of-loop.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i916xb1y0

RnJvbSAwYTkxNzVhZGRmZGU1N2JhNmQ3MjU1YTZkYjBiYjY1MzE2ZmQ4NjFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdWxpYW4gQ2FsYWJ5IDxqdWxpYW4uY2FsYWJ5QGdtYWlsLmNv
bT4KRGF0ZTogVHVlLCAyOCBBcHIgMjAxNSAyMDo0NTo0OSArMTAwMApTdWJqZWN0OiBbUEFUQ0hd
IHNwYXJjNjQ6IHBjaTogTW92ZSBoeXBlcnZpc29yIHRlc3Qgb3V0IG9mIGxvb3AKClNpZ25lZC1v
ZmYtYnk6IEp1bGlhbiBDYWxhYnkgPGp1bGlhbi5jYWxhYnlAZ21haWwuY29tPgoKLS0tCiBhcmNo
L3NwYXJjL2tlcm5lbC9wY2kuYyB8IDEyICsrKysrKystLS0tLQogMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3NwYXJjL2tl
cm5lbC9wY2kuYyBiL2FyY2gvc3BhcmMva2VybmVsL3BjaS5jCmluZGV4IDNhNWM0MDIuLmQ1ZjA2
YmQgMTAwNjQ0Ci0tLSBhL2FyY2gvc3BhcmMva2VybmVsL3BjaS5jCisrKyBiL2FyY2gvc3BhcmMv
a2VybmVsL3BjaS5jCkBAIC0xMDgzLDE0ICsxMDgzLDE2IEBAIHN0YXRpYyBpbnQgX19pbml0IG9m
X3BjaV9zbG90X2luaXQodm9pZCkKIHsKIAlzdHJ1Y3QgcGNpX2J1cyAqcGJ1cyA9IE5VTEw7CiAK
KwlpZiAodGxiX3R5cGUgPT0gaHlwZXJ2aXNvcikgeworCQl3aGlsZSAoKHBidXMgPSBwY2lfZmlu
ZF9uZXh0X2J1cyhwYnVzKSkgIT0gTlVMTCkKKwkJCXBjaV9zdW40dl9idXNfc2xvdF9uYW1lcyhw
YnVzKTsKKworCQlyZXR1cm4gMDsKKwl9CisKIAl3aGlsZSAoKHBidXMgPSBwY2lfZmluZF9uZXh0
X2J1cyhwYnVzKSkgIT0gTlVMTCkgewogCQlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5vZGU7CiAKLQkJ
aWYgKHRsYl90eXBlID09IGh5cGVydmlzb3IpIHsKLQkJCXBjaV9zdW40dl9idXNfc2xvdF9uYW1l
cyhwYnVzKTsKLQkJCWNvbnRpbnVlOwotCQl9Ci0KIAkJaWYgKHBidXMtPnNlbGYpIHsKIAkJCS8q
IFBDSS0+UENJIGJyaWRnZSAqLwogCQkJbm9kZSA9IHBidXMtPnNlbGYtPmRldi5vZl9ub2RlOwot
LSAKMi4xLjQKCg==
--047d7b87472ce2db7d0514c69d9b--
