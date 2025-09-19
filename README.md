# RAG Chatbot Agent

## Project overview
This project implements an AI-powered support agent using Retrieval-Augmented Generation (RAG).  
Users can upload PDF documents (for example, FAQs, manuals, and policies) and query them through an interactive chatbot interface.  
The agent performs semantic retrieval over indexed document chunks (FAISS + SentenceTransformers) and returns concise answers together with source snippets, similarity scores, and suggested follow-up questions.

## Key features
- PDF ingestion and indexing: automatic splitting of documents into chunks and building a FAISS vector index  
- Semantic search: retrieves the most relevant passages to user queries using sentence embeddings  
- Chat interface: Gradio-based UI for interactive Q&A and PDF upload  
- Source tracing: displays top retrieved snippets with similarity scores for transparency  
- Follow-up suggestions: proposes related questions based on retrieved chunks  
- Transcript logging: saves interactions to a CSV file  
- Memory efficient: designed to run within typical 12 GB RAM environments for moderate knowledge bases  

## File structure
```
ROOMAN AI/
├─ RAG_Chatbot_Agent.ipynb   # Main notebook with the full pipeline and UI
├─ Chatbot_UI.png            # Screenshot of the Gradio UI
├─ requirements.txt          # Python dependencies
└─ README.md                 # This file
```

## Tech stack
- Python 3.8+ (recommended 3.9/3.10)  
- SentenceTransformers (`all-MiniLM-L6-v2`) for embeddings  
- FAISS (CPU) for vector indexing and search  
- PyPDF to extract text from PDFs  
- FPDF to generate example PDFs (optional)  
- Gradio for the interactive UI  
- Pandas, NumPy, tqdm for utilities and processing  

## How to run (local or Colab)
1. Clone or download the project folder  
2. Create and activate a virtual environment (recommended):
   ```bash
   python -m venv venv
   source venv/bin/activate   # macOS / Linux
   venv\Scripts\activate      # Windows
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
4. Open the notebook:
   ```bash
   jupyter notebook RAG_Chatbot_Agent.ipynb
   ```
   or run in Google Colab (upload the notebook and run all cells)  
5. Run all cells from top to bottom. The notebook creates a sample FAQ PDF and builds an index the first time  
6. In the Gradio UI:
   - Upload a PDF or use the sample FAQ  
   - Ask a question in the chat box and review the answer, retrieved sources, confidence score, and suggested follow-ups  

## Notes and best practices
- The ingestion step uses a hybrid chunking strategy. For FAQ-style documents the code detects `Qn.` markers and splits accordingly; otherwise it falls back to paragraph/character chunking  
- If you change the ingestion logic, delete the old FAISS index folder (`faiss_index`) before re-indexing to avoid accumulating stale vectors  
- The confidence score is a heuristic derived from average similarity across retrieved chunks. It is intended as a signal, not an absolute correctness metric  
- The follow-up suggestions are generated heuristically from retrieved chunks. For more natural follow-ups and better synthesis, integrate an LLM call that consumes the retrieved snippets  

## Troubleshooting
- If the UI shows an internal error, check the log at `support_bot_data/gradio_handler_errors.log` (or the path used in your notebook) for a traceback  
- If the index contains unexpectedly few vectors, re-run the ingestion cell and ensure the text extraction worked for the input PDF  
- For large document collections, consider using an external vector DB (e.g., Weaviate, Milvus, Supabase) for persistence and scalability  

## Future improvements
- LLM-based synthesis for concise answers and higher-quality follow-ups  
- Multi-document and multi-user session management  
- Deployment on Hugging Face Spaces or a small cloud instance for public demos  
- Add access control and logging/analytics dashboards  

## Contact
For questions about this submission or to request the demo link, contact: [swapnilraj100@gmail.com]
