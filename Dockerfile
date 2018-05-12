FROM crystallang/crystal

ADD . /doc_store
WORKDIR /doc_store

RUN shards install
RUN crystal spec
RUN crystal build --release src/doc_store.cr

EXPOSE 5000

CMD ./doc_store -p 5000
